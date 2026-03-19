Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F8B1090227
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 14:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3E1W-0003Zm-6O; Thu, 19 Mar 2026 10:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3E1O-0003ZA-C7
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 10:06:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3E1L-0003fw-N9
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 10:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773929202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L8zuos4bK0fGs5bKQ5veSNqyz1ldnM7+UP90yWuOXfA=;
 b=Hm4KJCY2GzPgFAjxWoZDztMaS+v/un0WwDZCogWfjCC9zbbojzSXDy/rYQALjsomJia1+x
 bqDZKvKseRz3DOXCOfNaAkj4fDH33xi55+V63O9d/hW9oXUw5y+W59RmEiWEimY6DZbdwX
 ODnHTM9aKzdxXjdrPNV6i/06IDw1L9A=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-xlQAlMGwPLaNSq6RlLirJQ-1; Thu, 19 Mar 2026 10:06:41 -0400
X-MC-Unique: xlQAlMGwPLaNSq6RlLirJQ-1
X-Mimecast-MFC-AGG-ID: xlQAlMGwPLaNSq6RlLirJQ_1773929201
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-899edf0171bso90856926d6.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 07:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773929200; x=1774534000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L8zuos4bK0fGs5bKQ5veSNqyz1ldnM7+UP90yWuOXfA=;
 b=X9BCDDEmEkZDDIdVgDGeJBkY2RirEOjFNiL4KPOy1zI/vCFiFrXAdrMCDamlqpZZ7g
 g+mZjqD5t+MBir21j6oVnnBIR4m2f/st6dDlapmvLeuLo8MXG6ek1GU36VHQSYOMt0dv
 Rk8Yf5A7a0HlHAdNenxkc9dTqWdpkNhjet6KIJI20mWK5f2RkEQbMqc/gF/wo4yp0ryU
 AkwMD3C1mQyUSbT2CzBpoZu1fYR/rqqMKKVnmvnbay6jPAgEzzcqq6uER9aJm7mflfwL
 vLJsguiDa47zWPkTOhmJp/TjV9wpFMvOvLNawjoFbQDBWyxmevmRuuEf2k/+c9wPSXhq
 tW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773929200; x=1774534000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L8zuos4bK0fGs5bKQ5veSNqyz1ldnM7+UP90yWuOXfA=;
 b=TloyeFPlrfDAs0QB2quKs3CLaxA+UgbFGAqZYzFyJ5XRQKXJ/IAV4Z0CjE8OOme2kR
 zsSCv55lsJQryrZN9r8g6pxft5rtHClPKcP0oMRy8Gixcz4Gb/GgOUS948xn/PpUgg3V
 4VC1sp4kbKyQdjhfRMDzPulmIY6q/9ai1AkRRn6vAJKT8M+wMPX7Ymu2pW25rdgGkl/g
 5tBEBA81tJLUbDb8v3E/qat/RGbEPLulpQH0/pcjJylB3zMVEhGCFZjM9b7DE1h5dbj2
 GVbBRhgiu3WSQroNhCAfEcejBcg9Ku5deDKM/hoty/sVDM1k9ls6c0jconESxmo5/xIM
 DHzg==
X-Gm-Message-State: AOJu0Yxdw4atXQq50ssYcXUd+HUTpMA3LXi+CoGkG4bpu5GpUfII7qfo
 +QdiMejNeGpU7CDWxo0X0Xge3wa8NfqXg6cVMPnORzRtrsEwbx12gFhr6vk1bJeQl9tnBT++FV9
 ztw6dPy4ZG++04SPPYee10sVcrn+HYN8nEeL9g6SviboikYeTkx2F0TyfwXA+sahkb2+JMPuqDx
 vynsa82JpQcccSOcj5wqALb4nADPauu3OpQC6EAA==
X-Gm-Gg: ATEYQzxbTG42Sy1UDwnyIdSL+u8wurRnK2PU7OzOwWM3tGWUOroUIX2gLFrxU4zdxar
 l4tcG+7jztuovVqEzK3FdwyR0Ar7AljerlotVA3M3SVk8y2NJCScu/U6sjxaI0wRCfRZarfefve
 bHV8NWg2Y2Kuj+hKJ6nVEbnsYkE/PvaxUFgj/6SgUV+ORITFYHBIV7jNjtwErkc9DQmJnmAgtV6
 lnJPetu607OtEf18/mC3K1JBmL1Kdix+EQ19ufOEKRPEkSdW+EUExkXYYjNRmepyD86OnvEQTIq
 CuucUxPY05Jbc8PMNCvoQz2LbnzQP27i1Oi37xq85cUSfzqio3TxJiFvIMYFR29ZkOgTGfadWx/
 Z9SeWACGqxnw=
X-Received: by 2002:a05:6214:3204:b0:89c:6451:67ac with SMTP id
 6a1803df08f44-89c6b4b79c2mr116232966d6.12.1773929200467; 
 Thu, 19 Mar 2026 07:06:40 -0700 (PDT)
X-Received: by 2002:a05:6214:3204:b0:89c:6451:67ac with SMTP id
 6a1803df08f44-89c6b4b79c2mr116232126d6.12.1773929199854; 
 Thu, 19 Mar 2026 07:06:39 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c6b9ce294sm44932506d6.30.2026.03.19.07.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 07:06:39 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Kim Phillips <kim.phillips@amd.com>
Subject: [PULL 1/2] memory: Set mr->ram before RAM Block allocation
Date: Thu, 19 Mar 2026 10:06:35 -0400
Message-ID: <20260319140636.74007-2-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260319140636.74007-1-peterx@redhat.com>
References: <20260319140636.74007-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Commit 2fb627ef2f48 ("memory: Factor out common ram region initialization")
introduced a helper function memory_region_set_ram_block(), which causes
mr->ram to be set to true after the RAM Block allocation by
qemu_ram_alloc_*().

It leads to the assertion

  g_assert(memory_region_is_ram(mr));

in memory_region_set_ram_discard_manager() being triggered when creating
RAM Block with the RAM_GUEST_MEMFD flag.

Fix this by restoring the original behavior of setting mr->ram before
RAM Block allocation.

Closes: https://gitlab.com/qemu-project/qemu/-/work_items/3330
Reported-by: Farrah Chen <farrah.chen@intel.com>
Link: https://lore.kernel.org/r/df63fdf0-05ea-4de0-8009-c52703e4b052@amd.com
Reported-by: Kim Phillips <kim.phillips@amd.com>
Fixes: 2fb627ef2f48 ("memory: Factor out common ram region initialization")
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Tested-by: Kim Phillips <kim.phillips@amd.com>
Link: https://lore.kernel.org/r/20260312063420.973637-1-xiaoyao.li@intel.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 system/memory.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 17a7bcd9af..56f3225b21 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1578,7 +1578,6 @@ void memory_region_init_io(MemoryRegion *mr, Object *owner,
 
 static bool memory_region_set_ram_block(MemoryRegion *mr, RAMBlock *rb)
 {
-    mr->ram = true;
     mr->terminates = true;
     mr->destructor = memory_region_destructor_ram;
     mr->ram_block = rb;
@@ -1597,6 +1596,7 @@ bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr, Object *owner,
     RAMBlock *rb;
 
     memory_region_init(mr, owner, name, size);
+    mr->ram = true;
     rb = qemu_ram_alloc(size, ram_flags, mr, errp);
     return memory_region_set_ram_block(mr, rb);
 }
@@ -1614,6 +1614,7 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
     RAMBlock *rb;
 
     memory_region_init(mr, owner, name, size);
+    mr->ram = true;
     rb = qemu_ram_alloc_resizeable(size, max_size, resized, mr, errp);
     return memory_region_set_ram_block(mr, rb);
 }
@@ -1628,6 +1629,7 @@ bool memory_region_init_ram_from_file(MemoryRegion *mr, Object *owner,
     RAMBlock *rb;
 
     memory_region_init(mr, owner, name, size);
+    mr->ram = true;
     mr->readonly = !!(ram_flags & RAM_READONLY);
     mr->align = align;
     rb = qemu_ram_alloc_from_file(size, mr, ram_flags, path, offset, errp);
@@ -1642,6 +1644,7 @@ bool memory_region_init_ram_from_fd(MemoryRegion *mr, Object *owner,
     RAMBlock *rb;
 
     memory_region_init(mr, owner, name, size);
+    mr->ram = true;
     mr->readonly = !!(ram_flags & RAM_READONLY);
     rb = qemu_ram_alloc_from_fd(size, size, NULL, mr, ram_flags, fd, offset,
                                 false, errp);
@@ -1663,6 +1666,7 @@ void memory_region_init_ram_ptr(MemoryRegion *mr, Object *owner,
                                 void *ptr)
 {
     memory_region_init(mr, owner, name, size);
+    mr->ram = true;
     memory_region_set_ram_ptr(mr, size, ptr);
 }
 
@@ -1671,6 +1675,7 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr, Object *owner,
                                        void *ptr)
 {
     memory_region_init_io(mr, owner, &ram_device_mem_ops, mr, name, size);
+    mr->ram = true;
     mr->ram_device = true;
     memory_region_set_ram_ptr(mr, size, ptr);
 }
@@ -3699,7 +3704,6 @@ bool memory_region_init_rom_device(MemoryRegion *mr, Object *owner,
     memory_region_init_io(mr, owner, ops, opaque, name, size);
     rb = qemu_ram_alloc(size, 0, mr, errp);
     if (memory_region_set_ram_block(mr, rb)) {
-        mr->ram = false;
         mr->rom_device = true;
         memory_region_register_ram(mr, owner);
         return true;
-- 
2.50.1


