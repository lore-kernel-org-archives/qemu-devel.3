Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4F9C71159
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 21:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRHBi-0001n2-8x; Mon, 16 Jun 2025 17:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uRHBf-0001lQ-TZ
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 17:16:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uRHBc-00051E-U5
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 17:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750108570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tcd4dbglLSCOiuJ/nJX96YmhKJtOYx7qlmVMX+T1vX8=;
 b=Pb4fZ7rCkc2nAdSwF+72dXJOaG/tm6NVwjtPfDVDpc0wSvWRq2aC495Ynpo4uR/QKIgSE/
 fkyxW9Oz7dstRORSLJ5/XOJ9TUQvfmK/VBkLyXF2iu2CAJb9tfc6P1mXezKXC61L3fjNRI
 twMdbgRsgngLHWIeHQXJD1sMZJ04ZYY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-C5CTIwZgNNmGsA_S_hDqzQ-1; Mon,
 16 Jun 2025 17:16:08 -0400
X-MC-Unique: C5CTIwZgNNmGsA_S_hDqzQ-1
X-Mimecast-MFC-AGG-ID: C5CTIwZgNNmGsA_S_hDqzQ_1750108568
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EBE1119560BB
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 21:16:07 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.82])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 85E3B180035E; Mon, 16 Jun 2025 21:16:05 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	armbru@redhat.com,
	eblake@redhat.com
Cc: John Snow <jsnow@redhat.com>
Subject: [PATCH] docs/contrib: add insert_crossrefs script
Date: Mon, 16 Jun 2025 17:16:04 -0400
Message-ID: <20250616211604.1399219-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This isn't really meant for inclusion as it's a bit of a hackjob, but I
figured it would be best to share it in some form or another to serve as
a basis for a kind of meta-review of the crossreferenceification series.

This script is designed to convert 'name', "name", name, and @name
instances in qapi/*.json files to `name` for the purposes of
cross-referencing commands, events, and data types in the generated HTML
documentation. It is specifically tuned for our QAPI files and is not
suitable for running on generic rST source files. It can likely be made
to operate on QEMU guest agent or other qapi JSON files with some edits
to which files its opening.

Navigate to your qemu/qapi/ directory and run this script with "python
insert_crossrefs.py" and it'll handle the rest. Definitely don't run it
in a non-git-controlled folder, it edits your source files.

(Yes, in polishing this script, I found a few instances of
cross-references I missed in my v1 series. I figure I'll let us discuss
the conversion a bit before I send out a v2 patchbomb.)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 contrib/autoxref/insert_crossrefs.py | 69 ++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 contrib/autoxref/insert_crossrefs.py

diff --git a/contrib/autoxref/insert_crossrefs.py b/contrib/autoxref/insert_crossrefs.py
new file mode 100644
index 00000000000..399dd7524c2
--- /dev/null
+++ b/contrib/autoxref/insert_crossrefs.py
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import re
+import sys
+
+if not os.path.exists("qapi-schema.json"):
+    raise Exception(
+        "This script was meant to be run from the qemu.git/qapi directory."
+    )
+sys.path.append("../scripts/")
+
+from qapi.schema import QAPISchema, QAPISchemaDefinition
+
+# Adjust this global to exclude certain tokens from being xreffed.
+SKIP_TOKENS = ('String', 'stop', 'transaction', 'eject', 'migrate', 'quit')
+
+print("Compiling schema to build list of reference-able entities ...", end='')
+tokens = []
+schema = QAPISchema("qapi-schema.json")
+for ent in schema._entity_list:
+    if isinstance(ent, QAPISchemaDefinition) and not ent.is_implicit():
+        if ent.name not in SKIP_TOKENS:
+            tokens.append(ent.name)
+print("OK")
+
+patt_names = r'(' + '|'.join(tokens) + r')'
+
+# catch 'token' and "token" specifically
+patt = re.compile(r'([\'"]|``)' + patt_names + r'\1')
+# catch naked instances of token, excluding those where prefixed or
+# suffixed by a quote, dash, or word character. Exclude "@" references
+# specifically to handle them elsewhere. Exclude <name> matches, as
+# these are explicit cross-reference targets.
+patt2 = r"(?<![-@`'\"\w<])" + patt_names + r"(?![-`'\"\w>])"
+# catch @references. prohibit when followed by ":" to exclude members
+# whose names happen to match xreffable entities.
+patt3 = r"@" + patt_names + r"(?![-\w:])"
+
+
+
+
+for file in os.scandir():
+    outlines = []
+    if not file.name.endswith(".json"):
+        continue
+    print(f"Scanning {file.name} ...")
+    with open(file.name) as searchfile:
+        block_start = False
+        for line in searchfile:
+            # Don't mess with the start of doc blocks.
+            # We don't want to convert "# @name:" to a reference!
+            if block_start and line.startswith('# @'):
+                outlines.append(line)
+                continue
+            block_start = bool(line.startswith('##'))
+
+            # Don't mess with anything outside of comment blocks,
+            # and don't mess with example blocks. We use five spaces
+            # as a heuristic for detecting example blocks. It's not perfect,
+            # but it seemingly does the job well.
+            if line.startswith('# ') and not line.startswith('#     '):
+                line = re.sub(patt, r'`\2`', line)
+                line = re.sub(patt2, r'`\1`', line)
+                line = re.sub(patt3, r'`\1`', line)
+            outlines.append(line)
+    with open(file.name, "w") as outfile:
+        for line in outlines:
+            outfile.write(line)
-- 
2.48.1


