Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF7DD11181
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 15:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOHmv-0001K9-NL; Wed, 26 Nov 2025 10:50:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pzmarzly0@gmail.com>)
 id 1vOHmg-0000eo-5t
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 10:50:30 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pzmarzly0@gmail.com>)
 id 1vOHmc-0000vp-CH
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 10:50:21 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso73497175e9.3
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 07:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764172216; x=1764777016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OnYA1X95KyQj+3iDTUiFgqfXlpUaFheDZtHSW65r120=;
 b=H02RJbDKKGVVxKsLuyL4I6JDeYVZ3XnJ/jCXb4ONlWYw6Aq7etoMaqi6cgpfo+VJS+
 vKkXQ3+rCxZ2Dd90+K7dqi0WeGg0qKHmH9Mr8sp4upGguG6z3IZpT84Ts22Ee8uhCxlD
 oHbaB8FgqMDQL8WSmgMordvCDrjxK7n/10724obCQy21GExmEPgvtIjEBfkA5QQB0eBZ
 rVrTSSDpOttSIKtbcB2geeDJX91FiDHtmfX4rBJoMygwbhy8uWrg6nqIclAUfs4bsGqF
 F43q6ADrfioDSd2hzZk1ZDpz4dlXljEir8Z57IdDvfEmZ6C66/G/cOpwWdsB9X8DOiKv
 Mp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764172216; x=1764777016;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OnYA1X95KyQj+3iDTUiFgqfXlpUaFheDZtHSW65r120=;
 b=aw1ffAzWjdVMXz4xEQhNEBA8yQNjdA5At1g/UY4XY6SN+T1nqajqr1lsn54XyGXWh9
 C+nvFD5fWK4qThs1fJ55OZE826vmB3FgFY33gUWJhO22OTTYg0IoR4oEpN8G22j+3Fxy
 6NNkpdv+Qlw1aL89PfvMonci8yNAxok5hCqOfwYpOPkl7Pj7ZhjJHB+fc8x7GodRmWL4
 3Sy2gA/StAWpAdRpGHQindRGb6RonH+zS9b8btx1oMsfYulup4BKGxG92GA+hNG+V4xU
 XGnzs4My7Ka+N/7j8Ddo8rPWZ8ZHOVVfYhC6taUX1SyIHmSUtTTmLa4QhQrRBL6Rgm1B
 5jlA==
X-Gm-Message-State: AOJu0Yw+XC4pkWDpCtjHWX7lY0g8BlL1IbVBLxBKPoI1Jv/Gji5zVx/m
 A0+2mImatxGg/tivS0pTrOIyu2JptFnE7662TCz1gZFa1AQLCdk2OchdTsdh2/e4QOo=
X-Gm-Gg: ASbGnct4TZf5ILDpNZC4A/RsObUUzfn/UBwTGJ89a2VionEkIZffbtc+LWRUMZuI1Dd
 0BiMDwR+JBL7dgRfye32oWQ39YqpQFo7uR2iLb4H4fQ4MLpPq6NLr/X9PVYWFTY47UZVevvKFG7
 wufoRQXFZW1DJFeGzJCp18kb7o3aUc+u3Wn4nzj9IPjdoaPXa0ZJcXS2Y7yU1Ev1pE3pHCCEH0U
 WfKv665Puc0Mf0o5+p5+5JXsWiGfRCDfSuC8rPrcnODiji+chP9JoBgUR6pIec79JySlbKThRhL
 GTartf4BErTt4Jltl5yKhCU+0V3+cjKXq5h6hnloy49m0LBTiGY4CRGU1Jfyxzmgtdg6pG9Ewfg
 CwGfnNC/L9U/cUw1s+eC7WxTbnHK20UJSAOsQetjjgnHjLEqsfY3Q3kikyl4hBMXlz5w/kiDXaJ
 0nF7+8A3KgUrIelNo7Wg==
X-Google-Smtp-Source: AGHT+IE7DUgFjwWjluQAHGDdI8gADleYB4sWACIBSDGGH04dQFxBvuOvU8SXd81J9l8WV60Uv6+aew==
X-Received: by 2002:a05:600c:350e:b0:477:ae31:1311 with SMTP id
 5b1f17b1804b1-477c10e2a64mr174739785e9.13.1764172216304; 
 Wed, 26 Nov 2025 07:50:16 -0800 (PST)
Received: from localhost ([109.76.183.78]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479040c5f89sm48504525e9.2.2025.11.26.07.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 07:50:15 -0800 (PST)
From: Pawel Zmarzly <pzmarzly0@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de
Subject: [PATCH v2] scripts/analyze-migration: Support mapped-ram snapshot
 format
Date: Wed, 26 Nov 2025 15:50:15 +0000
Message-ID: <20251126155015.941129-1-pzmarzly0@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=pzmarzly0@gmail.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The script has not been updated to read mapped-ram snapshots and is currently
crashing when trying to read such a file.

With this commit, it can now read a snapshot created with:

    (qemu) migrate_set_capability x-ignore-shared on
    (qemu) migrate_set_capability mapped-ram on
    (qemu) migrate -d file:vm.state

Signed-off-by: Pawel Zmarzly <pzmarzly0@gmail.com>
---
V2: Added support for format change in my other patch "migration: Fix writing
mapped_ram + ignore_shared snapshots". You can see whole stack at
https://gitlab.com/pzmarzly/qemu/-/commits/pzmarzly?ref_type=heads
---
 scripts/analyze-migration.py | 48 ++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index 3303c05358..b6694bbd23 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -19,6 +19,7 @@
 
 import json
 import os
+import math
 import argparse
 import collections
 import struct
@@ -127,6 +128,7 @@ def __init__(self, file, version_id, ramargs, section_key):
         self.dump_memory = ramargs['dump_memory']
         self.write_memory = ramargs['write_memory']
         self.ignore_shared = ramargs['ignore_shared']
+        self.mapped_ram = ramargs['mapped_ram']
         self.sizeinfo = collections.OrderedDict()
         self.data = collections.OrderedDict()
         self.data['section sizes'] = self.sizeinfo
@@ -170,6 +172,50 @@ def read(self):
                         self.files[self.name] = f
                     if self.ignore_shared:
                         mr_addr = self.file.read64()
+                    if self.mapped_ram:
+                        version = self.file.read32()
+                        if version != 1:
+                            raise Exception("Unsupported MappedRamHeader version %s" % version)
+                            
+                        page_size = self.file.read64()
+                        if page_size != self.TARGET_PAGE_SIZE:
+                            raise Exception("Page size mismatch in MappedRamHeader")
+
+                        bitmap_offset = self.file.read64()
+                        pages_offset = self.file.read64()
+                        
+                        if self.ignore_shared and bitmap_offset == 0 and pages_offset == 0:
+                            continue
+
+                        if self.dump_memory or self.write_memory:
+                            num_pages = len // page_size
+
+                            self.file.seek(bitmap_offset, os.SEEK_SET)
+                            bitmap_len = int(math.ceil(num_pages / 8))
+                            bitmap = self.file.readvar(size=bitmap_len)
+
+                            self.file.seek(pages_offset, os.SEEK_SET)
+                            for page_num in range(num_pages):
+                                page_addr = page_num * page_size
+
+                                is_filled = (bitmap[page_num // 8] >> page_num % 8) & 1
+                                if is_filled:
+                                    data = self.file.readvar(size=self.TARGET_PAGE_SIZE)
+                                    if self.write_memory:
+                                        self.files[self.name].seek(page_addr, os.SEEK_SET)
+                                        self.files[self.name].write(data)
+                                    if self.dump_memory:
+                                        hexdata = " ".join("{0:02x}".format(c) for c in data)
+                                        self.memory['%s (0x%016x)' % (self.name, page_addr)] = hexdata
+                                else:
+                                    self.file.seek(self.TARGET_PAGE_SIZE, os.SEEK_CUR)
+                                    if self.write_memory:
+                                        self.files[self.name].seek(page_addr, os.SEEK_SET)
+                                        self.files[self.name].write(b'\x00' * self.TARGET_PAGE_SIZE)
+                                    if self.dump_memory:
+                                        self.memory['%s (0x%016x)' % (self.name, page_addr)] = 'Filled with 0x00'
+
+                        self.file.seek(pages_offset + len, os.SEEK_SET)
                 flags &= ~self.RAM_SAVE_FLAG_MEM_SIZE
 
             if flags & self.RAM_SAVE_FLAG_COMPRESS:
@@ -663,6 +709,7 @@ def read(self, desc_only = False, dump_memory = False,
         ramargs['dump_memory'] = dump_memory
         ramargs['write_memory'] = write_memory
         ramargs['ignore_shared'] = False
+        ramargs['mapped_ram'] = False
         self.section_classes[('ram',0)][1] = ramargs
 
         while True:
@@ -674,6 +721,7 @@ def read(self, desc_only = False, dump_memory = False,
                 section = ConfigurationSection(file, config_desc)
                 section.read()
                 ramargs['ignore_shared'] = section.has_capability('x-ignore-shared')
+                ramargs['mapped_ram'] = section.has_capability('mapped-ram')
             elif section_type == self.QEMU_VM_SECTION_START or section_type == self.QEMU_VM_SECTION_FULL:
                 section_id = file.read32()
                 name = file.readstr()
-- 
2.52.0

