Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81475E7718B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2024 19:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tP53l-0002R6-JT; Sat, 21 Dec 2024 14:22:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tP53k-0002Qo-9Q
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 14:22:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tP53i-0000Kl-M6
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 14:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734808962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TyHETmSFfRkani9FLrh+iELen8TJf3jh3hXnkuxCM7M=;
 b=B/7mzEOsSvc5vMSmRHTPrVk00yPnvKixGjp3bW1gf1MjnDl8tsZ5URMj8f3jz3NmLPnw35
 XxZx1i6mpSVCAkrWNfHncrBj/PCBLj2uQkPrX6rwfVghUp+ysbwqfEuAy3DUQ19B8m6iqL
 J4LMu+E9n1VgNZ/HKJX4dVtpIlQyoto=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-0QYQxfZWMh20j5WO0MSz0A-1; Sat, 21 Dec 2024 14:22:38 -0500
X-MC-Unique: 0QYQxfZWMh20j5WO0MSz0A-1
X-Mimecast-MFC-AGG-ID: 0QYQxfZWMh20j5WO0MSz0A
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385df115288so1411046f8f.2
 for <qemu-devel@nongnu.org>; Sat, 21 Dec 2024 11:22:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734808957; x=1735413757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TyHETmSFfRkani9FLrh+iELen8TJf3jh3hXnkuxCM7M=;
 b=hYAe+42ESsrhu/wRddFc9mH3l72qZdse9+6YN4KyrANGfRE+Sknd+kClG/0YYKLU3Q
 huTQY99Q+KhveooQtVQxKHCe6SU11GZRZYPHQNS7RXh2BIypMO78E7LRn4AoCdGs60s5
 aSXm8YA9xyM+SHnpDAtbsvq8K3S6zyD+0X7KzX4TqDMKQSw8f870qn6RKUYMFksjb1cA
 Vwvn5C639eZAuEk6ceqeP1AMae66wYlb+lrPWf7BNlqh+9SypZzgF+26+sTjSdfzPT74
 bxpSDVFImVAeHYNoUABKCnAWW59SbRoD8ywZkbe4EYIN3+T+R8/CHgsK7r+fGEAPBbdv
 iD4w==
X-Gm-Message-State: AOJu0YxiNXMm58BQQ1zsnzParZQx7NBI+/OSgnXgYy6L/0h52pxAvEql
 Y74JVAWPTrgU99Wns9LYwD7tdg1pNUFBaxejoxzfXQJHwsnlM31tmiY+0R/9FYXNGLk0heE72VP
 WY3oFWUojH1XXViS4u06RfSI9eWNvFyL8Rk50P+IUo5UAH0OTdWk1SvvxiufYyqsvf9KGUWMspZ
 Pf72uMT1A0xSfAKxtTwh3NiMCz5cKVzYAn
X-Gm-Gg: ASbGnctMcTc/9zAC0XhhCAnBS6KLOOyvcydNOxZAzmJeqxk7nq6P2CrOcAhDGtdLac+
 RcB9Bfr4HmIfyxSz5bx078TLp/QI6+v6BtbMvrBJZeXy77FNa1zuJi7NFcRdE+uKrdf/z14mP2F
 j/soehlncPYdjV/RPLEnBlmh3nz7ktkA4FV5opf+3FdQKp8CmXTXT2gboDtbo22tl4aPtfYyg42
 jD4XQuM0oT42YMXcgeIMdwfD7gD8Gper1sX2YlC8wmSoXmJcMomBHQAB5DOxrlbx544Daz7zPRU
 ChbF1gmVgdM7lPJmD2y/BQwe+IpbZ1jYIci2pyo=
X-Received: by 2002:a05:6000:71b:b0:385:fab3:c56d with SMTP id
 ffacd0b85a97d-38a221685c4mr7121846f8f.0.1734808957402; 
 Sat, 21 Dec 2024 11:22:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1gaHU8eFWPAQqJ2ZbDNX9RSfGulkjNHaH8H6K5MjIqXuyLemJBQJ2UnH1RR6jGFO6+Swrrg==
X-Received: by 2002:a05:6000:71b:b0:385:fab3:c56d with SMTP id
 ffacd0b85a97d-38a221685c4mr7121830f8f.0.1734808957060; 
 Sat, 21 Dec 2024 11:22:37 -0800 (PST)
Received: from localhost
 (p200300cbc7137800820d0e9f08ce52bd.dip0.t-ipconnect.de.
 [2003:cb:c713:7800:820d:e9f:8ce:52bd])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-38a1c8474a9sm7072492f8f.52.2024.12.21.11.22.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Dec 2024 11:22:35 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL v2 09/15] s390x/s390-stattrib-kvm: prepare for memory devices
 and sparse memory layouts
Date: Sat, 21 Dec 2024 20:22:03 +0100
Message-ID: <20241221192209.3979595-10-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241221192209.3979595-1-david@redhat.com>
References: <20241221192209.3979595-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.177,
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

With memory devices, we will have storage attributes for memory that
exceeds the initial ram size. Further, we can easily have memory holes,
for which there (currently) are no storage attributes.

In particular, with memory holes, KVM_S390_SET_CMMA_BITS will fail to set
some storage attributes.

So let's do it like we handle storage keys migration, relying on
guest_phys_blocks_append(). However, in contrast to storage key
migration, we will handle it on the migration destination.

This is a preparation for virtio-mem support. Note that ever since the
"early migration" feature was added (x-early-migration), the state
of device blocks (plugged/unplugged) is migrated early such that
guest_phys_blocks_append() will properly consider all currently plugged
memory blocks and skip any unplugged ones.

In the future, we should try getting rid of the large temporary buffer
and also not send any attributes for any memory holes, just so they
get ignored on the destination.

Message-ID: <20241219144115.2820241-9-david@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-stattrib-kvm.c | 67 +++++++++++++++++++++++-------------
 1 file changed, 43 insertions(+), 24 deletions(-)

diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
index eeaa811098..33ec91422a 100644
--- a/hw/s390x/s390-stattrib-kvm.c
+++ b/hw/s390x/s390-stattrib-kvm.c
@@ -10,11 +10,12 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/boards.h"
+#include "hw/s390x/s390-virtio-ccw.h"
 #include "migration/qemu-file.h"
 #include "hw/s390x/storage-attributes.h"
 #include "qemu/error-report.h"
 #include "sysemu/kvm.h"
+#include "sysemu/memory_mapping.h"
 #include "exec/ram_addr.h"
 #include "kvm/kvm_s390x.h"
 #include "qapi/error.h"
@@ -84,8 +85,8 @@ static int kvm_s390_stattrib_set_stattr(S390StAttribState *sa,
                                         uint8_t *values)
 {
     KVMS390StAttribState *sas = KVM_S390_STATTRIB(sa);
-    MachineState *machine = MACHINE(qdev_get_machine());
-    unsigned long max = machine->ram_size / TARGET_PAGE_SIZE;
+    S390CcwMachineState *s390ms = S390_CCW_MACHINE(qdev_get_machine());
+    unsigned long max = s390_get_memory_limit(s390ms) / TARGET_PAGE_SIZE;
 
     if (start_gfn + count > max) {
         error_report("Out of memory bounds when setting storage attributes");
@@ -103,39 +104,57 @@ static int kvm_s390_stattrib_set_stattr(S390StAttribState *sa,
 static void kvm_s390_stattrib_synchronize(S390StAttribState *sa)
 {
     KVMS390StAttribState *sas = KVM_S390_STATTRIB(sa);
-    MachineState *machine = MACHINE(qdev_get_machine());
-    unsigned long max = machine->ram_size / TARGET_PAGE_SIZE;
-    /* We do not need to reach the maximum buffer size allowed */
-    unsigned long cx, len = KVM_S390_SKEYS_MAX / 2;
+    S390CcwMachineState *s390ms = S390_CCW_MACHINE(qdev_get_machine());
+    unsigned long max = s390_get_memory_limit(s390ms) / TARGET_PAGE_SIZE;
+    unsigned long start_gfn, end_gfn, pages;
+    GuestPhysBlockList guest_phys_blocks;
+    GuestPhysBlock *block;
     int r;
     struct kvm_s390_cmma_log clog = {
         .flags = 0,
         .mask = ~0ULL,
     };
 
-    if (sas->incoming_buffer) {
-        for (cx = 0; cx + len <= max; cx += len) {
-            clog.start_gfn = cx;
-            clog.count = len;
-            clog.values = (uint64_t)(sas->incoming_buffer + cx);
-            r = kvm_vm_ioctl(kvm_state, KVM_S390_SET_CMMA_BITS, &clog);
-            if (r) {
-                error_report("KVM_S390_SET_CMMA_BITS failed: %s", strerror(-r));
-                return;
-            }
-        }
-        if (cx < max) {
-            clog.start_gfn = cx;
-            clog.count = max - cx;
-            clog.values = (uint64_t)(sas->incoming_buffer + cx);
+    if (!sas->incoming_buffer) {
+        return;
+    }
+    guest_phys_blocks_init(&guest_phys_blocks);
+    guest_phys_blocks_append(&guest_phys_blocks);
+
+    QTAILQ_FOREACH(block, &guest_phys_blocks.head, next) {
+        assert(QEMU_IS_ALIGNED(block->target_start, TARGET_PAGE_SIZE));
+        assert(QEMU_IS_ALIGNED(block->target_end, TARGET_PAGE_SIZE));
+
+        start_gfn = block->target_start / TARGET_PAGE_SIZE;
+        end_gfn = block->target_end / TARGET_PAGE_SIZE;
+
+        while (start_gfn < end_gfn) {
+            /* Don't exceed the maximum buffer size. */
+            pages = MIN(end_gfn - start_gfn, KVM_S390_SKEYS_MAX / 2);
+
+            /*
+             * If we ever get guest physical memory beyond the configured
+             * memory limit, something went very wrong.
+             */
+            assert(start_gfn + pages <= max);
+
+            clog.start_gfn = start_gfn;
+            clog.count = pages;
+            clog.values = (uint64_t)(sas->incoming_buffer + start_gfn);
             r = kvm_vm_ioctl(kvm_state, KVM_S390_SET_CMMA_BITS, &clog);
             if (r) {
                 error_report("KVM_S390_SET_CMMA_BITS failed: %s", strerror(-r));
+                goto out;
             }
+
+            start_gfn += pages;
         }
-        g_free(sas->incoming_buffer);
-        sas->incoming_buffer = NULL;
     }
+
+out:
+    guest_phys_blocks_free(&guest_phys_blocks);
+    g_free(sas->incoming_buffer);
+    sas->incoming_buffer = NULL;
 }
 
 static int kvm_s390_stattrib_set_migrationmode(S390StAttribState *sa, bool val,
-- 
2.47.1


