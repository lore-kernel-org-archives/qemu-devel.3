Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7365FE6F090
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3P3-00015C-GG; Tue, 23 Dec 2025 09:30:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3Ou-00010p-Pg
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3Os-0003gy-JT
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766500209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A598UVmqzqXHgD15lHZQkjUxN1DyybTu+2VPcZiG4yU=;
 b=P0zDYdzFBkkThTzWh9Zaf8BCAgPEXmxIkrqd0chJT4vVbteJ5KyPSUuhzUIVj/TZODwsmH
 R0jxo3N1ks4EYvr66eh/NblKcUsXjvRNdUyzrkVpk1Sg+Pczwr5FRumJreg7BCycV+die7
 6EkT6aVgkhXP5uaWA5PEJSsWiP9qetg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-QcBuu-jwPw2Ve1QIFreh2g-1; Tue, 23 Dec 2025 09:30:08 -0500
X-MC-Unique: QcBuu-jwPw2Ve1QIFreh2g-1
X-Mimecast-MFC-AGG-ID: QcBuu-jwPw2Ve1QIFreh2g_1766500208
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8bbe16e0a34so1182734485a.1
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 06:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766500208; x=1767105008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A598UVmqzqXHgD15lHZQkjUxN1DyybTu+2VPcZiG4yU=;
 b=VCxmQd47aIdt9FDDuC7rz8n8bmvl87Mz/joH1fkM7U/k7IGOMhIhhfdQnQ4NL6k/wl
 0K3W3LJXgWLhcMU9utItvHzC0HMtqlpFjvVwofrxlbRFLsuilKlfTAXaMcpmIbkBQ2hT
 NO3IVkWW6SrFgLbHciNO6ONe6kVt2lakKS0yFiP+RegsK8x60yhs8u3qGf1sKa9DvGId
 K3DShZpacp+qqykVGI8QzYTWBORiYxPy0/l3ctABYadc2ZMQAAAGyRxL6mSA2FEyA14T
 xOURz0WCiTOiPVkDYPbTVdS/Wufu9CZha+eNBxX2DETTbcmntHGixyfp4CVPsYI0Yctr
 xLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766500208; x=1767105008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A598UVmqzqXHgD15lHZQkjUxN1DyybTu+2VPcZiG4yU=;
 b=TMlyLsYABDfa1Lvg9kPwjzGYsDEbzpqvWEM4+QztZ6QoEcCsHfBy72shc+ZiXQ4RPn
 I5a537MiR2cAAOH8OViFnZcbZDW/piRTajlgOXWAs/B5YKgYcUX4X+niyJXNx6/oKc64
 UYPLcdvtnWIA46iRaKs7bTnxgdE7xRNZJXz8vnYnoJIteXKSi9QyGr1QcvOznJjR72yb
 si14gl2FErdAcT/1b3i1/NKc9qIkTuRkDYzu9Ny9V08WGAT/dPSLrbTWrfQvk6qyi0e4
 epV/QmWKRMjKxY2ImoRW+NDwzS59gyt/Davo025PsAxYxAQtF1xswDknHkWEhohRg8GD
 oXvA==
X-Gm-Message-State: AOJu0YyawjJ+GafFOZuQGd0i5xuGWJFFCXhmcuO6rfoPgifg8O8DsG2X
 YOrcdx+LU8oWFzFMEAgyU8nqTOkmVLcZq/jyoQaziaIkl8dWVUBJlfhr3nvUVoMHX8pxn7X2RR2
 G1qz7Fz2I3yO1PH3Bh+IlAq+1bFHkgz3rVkC8q2ViugZeK2XxW6spp2NLtKpgY3+KRD26A5kGa4
 8pAeQnliJ6+1F+iB68LU25XkwAk6Cai308vQgmpQ==
X-Gm-Gg: AY/fxX4lVQ2jEKQwct4lf8iECbzqCR2M7blMMHVntmpuYv0ljsC94fbIGt4cCzHOaNc
 BvUcb06v63kDtC4E0v2TzeX7Uc4ligvb205NTiWLddndV5vqUm6vqEagVJOtbO34i2B+eb0gafP
 t6t5vOJrda+jlQO6JWgvfVPwwMdb0UVkfTgzZi5EXWfEnK3UfBlAnrXIgkEfK3iG1HeC5qh4xuz
 8pFSuzrJ8BkVZjvoUGOPPg/SLpewDDb76eAjKJk8fhpt3b620lwsEvdBqYKMagvy9jjANYR3WQu
 L3DP6ScYCu1tsjsYLPx6EdFuVdAujaDa7y/J59T8U3PvzAfJZ3hEP7KKuHvI/2x6NXz76bI4t/l
 Gslk=
X-Received: by 2002:a05:620a:2945:b0:8a3:6c1f:31cb with SMTP id
 af79cd13be357-8c090029a91mr1954645585a.26.1766500207522; 
 Tue, 23 Dec 2025 06:30:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAFH6TSdmN5RBehqX7dYZxmprB+98irmF/TR2qzTdacDSTD9zVbXSo99iDNPyE3lLh651l8A==
X-Received: by 2002:a05:620a:2945:b0:8a3:6c1f:31cb with SMTP id
 af79cd13be357-8c090029a91mr1954641085a.26.1766500207007; 
 Tue, 23 Dec 2025 06:30:07 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c096787536sm1096163285a.4.2025.12.23.06.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 06:30:06 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Pawel Zmarzly <pzmarzly0@gmail.com>
Subject: [PULL 04/31] scripts/analyze-migration: Support mapped-ram snapshot
 format
Date: Tue, 23 Dec 2025 09:29:32 -0500
Message-ID: <20251223142959.1460293-5-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251223142959.1460293-1-peterx@redhat.com>
References: <20251223142959.1460293-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Pawel Zmarzly <pzmarzly0@gmail.com>

The script has not been updated to read mapped-ram snapshots and is currently
crashing when trying to read such a file.

With this commit, it can now read a snapshot created with:

    (qemu) migrate_set_capability x-ignore-shared on
    (qemu) migrate_set_capability mapped-ram on
    (qemu) migrate -d file:vm.state

Signed-off-by: Pawel Zmarzly <pzmarzly0@gmail.com>
Link: https://lore.kernel.org/r/20251126155015.941129-1-pzmarzly0@gmail.com
[peterx: space fixes, introduce parseMappedRamBlob(), add comments, etc.]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 scripts/analyze-migration.py | 57 ++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index a12ea9fc8f..e81deab8f9 100755
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
@@ -146,6 +148,57 @@ def __str__(self):
     def getDict(self):
         return self.data
 
+    def parseMappedRamBlob(self, len):
+        version = self.file.read32()
+        if version != 1:
+            raise Exception("Unsupported MappedRamHeader version %s" % version)
+
+        page_size = self.file.read64()
+        if page_size != self.TARGET_PAGE_SIZE:
+            raise Exception("Page size mismatch in MappedRamHeader")
+
+        bitmap_offset = self.file.read64()
+        pages_offset = self.file.read64()
+
+        if self.ignore_shared and bitmap_offset == 0 and pages_offset == 0:
+            # This is a shared ramblock, x-ignore-share must have been
+            # enabled, and mapped-ram didn't allocate bitmap or page blob
+            # for it.
+            return
+
+        if self.dump_memory or self.write_memory:
+            num_pages = len // page_size
+
+            self.file.seek(bitmap_offset, os.SEEK_SET)
+            bitmap_len = int(math.ceil(num_pages / 8))
+            bitmap = self.file.readvar(size=bitmap_len)
+
+            self.file.seek(pages_offset, os.SEEK_SET)
+            for page_num in range(num_pages):
+                page_addr = page_num * page_size
+
+                is_filled = (bitmap[page_num // 8] >> page_num % 8) & 1
+                if is_filled:
+                    data = self.file.readvar(size=self.TARGET_PAGE_SIZE)
+                    if self.write_memory:
+                        self.files[self.name].seek(page_addr, os.SEEK_SET)
+                        self.files[self.name].write(data)
+                    if self.dump_memory:
+                        hexdata = " ".join("{0:02x}".format(c) for c in data)
+                        self.memory['%s (0x%016x)' %
+                                    (self.name, page_addr)] = hexdata
+                else:
+                    self.file.seek(self.TARGET_PAGE_SIZE, os.SEEK_CUR)
+                    if self.write_memory:
+                        self.files[self.name].seek(page_addr, os.SEEK_SET)
+                        self.files[self.name].write(
+                            b'\x00' * self.TARGET_PAGE_SIZE)
+                    if self.dump_memory:
+                        self.memory['%s (0x%016x)' %
+                                    (self.name, page_addr)] = 'Filled with 0x00'
+
+        self.file.seek(pages_offset + len, os.SEEK_SET)
+
     def read(self):
         # Read all RAM sections
         while True:
@@ -170,6 +223,8 @@ def read(self):
                         self.files[self.name] = f
                     if self.ignore_shared:
                         mr_addr = self.file.read64()
+                    if self.mapped_ram:
+                        self.parseMappedRamBlob(len)
                 flags &= ~self.RAM_SAVE_FLAG_MEM_SIZE
 
             if flags & self.RAM_SAVE_FLAG_ZERO:
@@ -660,6 +715,7 @@ def read(self, desc_only = False, dump_memory = False,
         ramargs['dump_memory'] = dump_memory
         ramargs['write_memory'] = write_memory
         ramargs['ignore_shared'] = False
+        ramargs['mapped_ram'] = False
         self.section_classes[('ram',0)][1] = ramargs
 
         while True:
@@ -671,6 +727,7 @@ def read(self, desc_only = False, dump_memory = False,
                 section = ConfigurationSection(file, config_desc)
                 section.read()
                 ramargs['ignore_shared'] = section.has_capability('x-ignore-shared')
+                ramargs['mapped_ram'] = section.has_capability('mapped-ram')
             elif section_type == self.QEMU_VM_SECTION_START or section_type == self.QEMU_VM_SECTION_FULL:
                 section_id = file.read32()
                 name = file.readstr()
-- 
2.50.1


